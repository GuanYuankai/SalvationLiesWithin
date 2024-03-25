Shader "URPPractice/LanBertLightShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BaseColor ("BaseColor", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { 
            "RenderType"="Opaque" 
            "RenderPipeline" = "UniversalRenderPipeline"
        }
        
        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

        CBUFFER_START(UnityPerMaterial)
        float4 _MainTex_ST;
        half4 _BaseColor;
        CBUFFER_END
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);

        struct a2v
        {
            float4 positionOS: POSITION;
            float4 normalOS: NORMAL;
            float2 uv: TEXCOORD0;
        };
        struct v2f
        {
            float4 positionCS: SV_POSITION;
            float2  uv: TEXCOORD0;
            float3 normalWS: TEXCOORD1;
        };
        ENDHLSL
        
        
        
        Pass
        {
            HLSLPROGRAM   
            #pragma vertex vert
            #pragma fragment frag
            v2f vert (a2v i)
            {
                v2f o;
                VertexPositionInputs positionInputs = GetVertexPositionInputs(i.positionOS.xyz);
                o.positionCS = positionInputs.positionCS;
                o.uv = TRANSFORM_TEX(i.uv, _MainTex);
                o.normalWS = TransformObjectToWorldNormal(i.normalOS.xyz,true);
                return o;
            }

            real4 frag (v2f i) : SV_Target
            {
                half4 tex = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv) * _BaseColor;
                Light _light = GetMainLight();
                real4 lightColor = real4(_light.color,1);
                float3 lightDir = normalize(_light.direction);
                float lightAten = dot(lightDir, i.normalWS);
                return tex * lightColor * lightAten;
            }
            ENDHLSL
        }
    }
}
