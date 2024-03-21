using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SkyBoxDrawer : MonoBehaviour
{
    public static Mesh fullScreenMesh
    {
        get
        {
            if (m_mesh != null)
                return m_mesh;
            m_mesh = new Mesh();
            m_mesh.vertices = new[]
            {
                new Vector3(-1, -1, 0),
                new Vector3(-1, 1, 0),
                new Vector3(1, 1, 0),
                new Vector3(1, -1, 0),
            };
            m_mesh.uv = new[]
            {
                new Vector2(0, 1),
                new Vector2(0, 0),
                new Vector2(1, 0),
                new Vector2(1, 1)

            };
            
            m_mesh.SetIndices(new int[]{0,1,2,3},MeshTopology.Quads,0);
            return m_mesh;
        }
    }

    private static Mesh m_mesh;
}
