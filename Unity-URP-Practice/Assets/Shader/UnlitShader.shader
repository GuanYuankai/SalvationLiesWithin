Shader "URPPractice/UnlitShader"
{
    Properties
    {
        _BaseMap ("BaseMap", 2D) = "white" {}
        _BaseColor ("BaseColor", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags {
            "RenderPipeline"="UniversalRenderPipeline"
            "RenderType"="Opaque" 
        }
        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        CBUFFER_START(UnityPerMaterial)
        float4 _BaseMap_ST;
        half4 _BaseColor;
        CBUFFER_END
        ENDHLSL
        
        Pass
        {
            HLSLPROGRAM 
            #pragma vertex vert
            #pragma fragment frag
            struct a2v
            {
                float4 positionOS: POSITION;
                float4 normalOS: NORMAL;
                float4 texcoord: TEXCOORD0;
            };
            struct v2f
            {   
                float4 positionCS: POSITION;
                float2 texcoord: TEXCOORD0;
            };
            TEXTURE2D(_BaseMap);
            SAMPLER(sampler_BaseMap);
            v2f vert (a2v v)
            {
                v2f o;
                VertexPositionInputs positionInputs = GetVertexPositionInputs(v.positionOS.xyz);
                o.positionCS = positionInputs.positionCS;
                o.texcoord = TRANSFORM_TEX(v.texcoord, _BaseMap);
                return o;
            }

            
            half4 frag (v2f i) : SV_Target
            {
                half4 tex = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.texcoord) * _BaseColor;
                return tex;
            }
            ENDHLSL
        }
    }
}
