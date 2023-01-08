using System.Collections;
using UnityEngine;

public class StreetViewSphere : MonoBehaviour
{
    [SerializeField] private float streetViewTransitionTime;

    private Camera camera;
    private Material streetViewMaterial;



    void Awake()
    {
        camera = Camera.main;

        streetViewMaterial = GetComponent<MeshRenderer>().sharedMaterial;
    }

    public void StartTransition(bool isTransitionFromPanorama1ToPanorama2, Vector3 distortionDirection)
    {
        // Stop currently running coroutine if possible
        StopAllCoroutines();

        // Set distortion direction to simulate the moving direction
        streetViewMaterial.SetVector("_DistortionDirection", distortionDirection);

        StartCoroutine(StreetViewTransitionCoroutine(isTransitionFromPanorama1ToPanorama2));
    }

    private IEnumerator StreetViewTransitionCoroutine(bool isTransitionFromPanorama1ToPanorama2)
    {
        // Blend and transit to new panorama gradually
        float transitionTime = streetViewTransitionTime;
        while (transitionTime > 0)
        {
            transitionTime -= Time.deltaTime;

            if (isTransitionFromPanorama1ToPanorama2)
                streetViewMaterial.SetFloat("_Blend", 1 - (transitionTime / streetViewTransitionTime)); //| _Blend = 0 -> 1
            else
                streetViewMaterial.SetFloat("_Blend", transitionTime / streetViewTransitionTime);       //| _Blend = 1 -> 0

            yield return null;
        }
    }

    private void OnDestroy()
    {
        // We reset the attribute on Destroy
        streetViewMaterial.SetVector("_DistortionDirection", Vector3.zero);
        streetViewMaterial.SetFloat("_Blend", 0);
    }
}