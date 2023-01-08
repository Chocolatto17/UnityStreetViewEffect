# Unity Street View Effect
Unity Street view effect, inspired from Google maps - Street view mode.

## Shader
Here is a simple Shader file and an example of usage to make your own street view effect.
![image](https://user-images.githubusercontent.com/51533097/211184955-a6297cf4-5568-4539-8250-e307513d1163.png)

## Material
Create a Material from the Shader above.

![image](https://user-images.githubusercontent.com/51533097/211184958-a4e8cdd6-f05c-4e74-a014-be23fa22653d.png)

#### Properties Explaination
| Property Name  | Usage |
| ------------- | ------------- |
| Panorama (HDR) 1 | A normal image in short (best used with panorama image). Use with Panorama (HDR) 2 to create the street view effect. |
| Panorama (HDR) 2 | A normal image in short (best used with panorama image). Use with Panorama (HDR) 1 to create the street view effect. |
| <a href="#tint-color">Tint Color</a> | Tint the image. |
| <a href="#exposure">Exposure</a> | Brightness of the image. |
| <a href="#rotation">Rotation</a> | Image's rotation around Y axis (where Y points up to the sky). |
| <a href="#blend-amount">Blend Amount</a> | Blend of alpha channel in color of both images. |
| <a href="#distortion-direction">Distortion Direction</a> | Direction to distort the image while blending, which made the street view effect. |

## Demo
I highly suggests you trying these properties by hand.
There is a demo scene called "StreetView" in the project, you can test it out.</br>

One note is, if you change value of Material's properties in Play mode, then exit to Editor mode, the value won't be reset.
This is because of how Unity's Material work.

### Tint Color
![image](https://user-images.githubusercontent.com/51533097/211186029-ef2e4900-9fbd-469b-92b0-a73004d38c25.png)

### Exposure
![Exposure](https://user-images.githubusercontent.com/51533097/211185613-db4b414e-0dde-48e4-9da1-5ec36fff46d3.gif)

### Rotation
![Rotation](https://user-images.githubusercontent.com/51533097/211185647-cf5ae7e2-5c47-4c33-9b50-7d52f76742ad.gif)

### Blend Amount
![Blend](https://user-images.githubusercontent.com/51533097/211185654-8d2c591d-89ff-43c1-9275-2e5d44db68f9.gif)

### Distortion Direction
![StreetView](https://user-images.githubusercontent.com/51533097/211185872-1e81d6d4-29fb-4bad-b529-69c0c067580c.gif)
