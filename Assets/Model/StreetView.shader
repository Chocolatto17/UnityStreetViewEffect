Shader "Unlit/StreetView" {
	Properties
	{
		[NoScaleOffset] _FirstTex("Panorama (HDR) 1", 2D) = "grey" {}
		[NoScaleOffset] _SecondTex("Panorama (HDR) 2", 2D) = "grey" {}
		_Tint("Tint Color", Color) = (.5, .5, .5, .5)
		[Gamma] _Exposure("Exposure", Range(0, 8)) = 1.0
		_Rotation("Rotation", Range(0, 360)) = 0
		_Blend("Blend Amount", Range(0.0,1.0)) = 0.0
		_DistortionDirection("Distortion Direction", Vector) = (0, 0, 0, 0)
	}

	SubShader 
	{
		Tags { "Queue" = "Background" "RenderType" = "Background" "PreviewType" = "Skybox" }
		Cull Off 
		//ZWrite Off

		Pass {

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _FirstTex;
			half4 _FirstTex_HDR;
			sampler2D _SecondTex;
			half4 _SecondTex_HDR;
			half4 _Tint;
			half _Exposure;
			float _Rotation;
			float _Blend;
			float4 _DistortionDirection;

			float4 RotateAroundYInDegrees(float4 vertex, float degrees)
			{
				float alpha = degrees * UNITY_PI / 180.0;
				float sina, cosa;
				sincos(alpha, sina, cosa);
				float2x2 m = float2x2(cosa, -sina, sina, cosa);
				return float4(mul(m, vertex.xz), vertex.yw).xzyw;
			}

			struct appdata_t {
				float4 vertex : POSITION;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float3 texcoord : TEXCOORD0;
				float3 texcoord2 : TEXCOORD1;
			};

			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(RotateAroundYInDegrees(v.vertex, _Rotation));
				_DistortionDirection = mul(unity_WorldToObject, _DistortionDirection) * float4(1, 4, 1, 0);
				o.texcoord = v.vertex.xyz;
				o.texcoord2 = v.vertex.xyz;
				UNITY_TRANSFER_FOG(o, o.vertex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				i.texcoord += _DistortionDirection * -_Blend;
				float3 dir1 = normalize(i.texcoord);
				float2 longlat1 = float2(atan2(dir1.x, dir1.z) + UNITY_PI, acos(-dir1.y));
				float2 uv1 = longlat1 / float2(2.0 * UNITY_PI, UNITY_PI);
				half4 tex1 = tex2D(_FirstTex, uv1);
				half3 c1 = DecodeHDR(tex1, _FirstTex_HDR);
				c1 *= _Tint.rgb * unity_ColorSpaceDouble.rgb;
				c1 *= _Exposure;

				i.texcoord2 += _DistortionDirection * (1.0 - _Blend);
				float3 dir2 = normalize(i.texcoord2);
				float2 longlat2 = float2(atan2(dir2.x, dir2.z) + UNITY_PI, acos(-dir2.y));
				float2 uv2 = longlat2 / float2(2.0 * UNITY_PI, UNITY_PI);
				half4 tex2 = tex2D(_SecondTex, uv2);
				half3 c2 = DecodeHDR(tex2, _SecondTex_HDR);
				c2 *= _Tint.rgb * unity_ColorSpaceDouble.rgb;
				c2 *= _Exposure;

				half3 col = lerp(c1, c2, _Blend);

				return half4(col, 1);
			}
			ENDCG
		}
	}

	Fallback Off
}