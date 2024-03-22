using UnityEngine;

public class CameraScript : MonoBehaviour
{
    public RenderTexture rt;
    public Transform[]cubeTransforms;
    public Mesh cubeMesh;
    public Material pureColorMaterial;
    
    public SkyboxDraw skyDraw;

    private void Start()
    {
        rt = new RenderTexture(Screen.width, Screen.height, 24);
    }

    private void OnPostRender()
    {
        Camera cam = Camera.current;
        Graphics.SetRenderTarget(rt);
        GL.Clear(true, true, Color.grey);
        
        
        //------- Start Drawcall
       
        pureColorMaterial.color = Color.green;
        pureColorMaterial.SetPass(0);
        foreach(var i in cubeTransforms)
        {
            Graphics.DrawMeshNow(cubeMesh, i.localToWorldMatrix);
        }
        skyDraw.DrawSkybox(cam); // renderQueue注意下，保证天空盒后渲染
        //------- End DrawCall
        Graphics.Blit(rt, cam.targetTexture);

    }

}
