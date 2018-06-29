// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33168,y:32672,varname:node_3138,prsc:2|emission-5434-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32476,y:32965,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_Time,id:350,x:32230,y:32717,varname:node_350,prsc:2;n:type:ShaderForge.SFN_HsvToRgb,id:5434,x:32962,y:32804,varname:node_5434,prsc:2|H-3136-OUT,S-5817-SOUT,V-5817-VOUT;n:type:ShaderForge.SFN_RgbToHsv,id:5817,x:32664,y:32965,varname:node_5817,prsc:2|IN-7241-RGB;n:type:ShaderForge.SFN_ValueProperty,id:4948,x:32230,y:32871,ptovrint:False,ptlb:Speed,ptin:_Speed,varname:node_4948,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Sin,id:3096,x:32565,y:32773,varname:node_3096,prsc:2|IN-7138-OUT;n:type:ShaderForge.SFN_Multiply,id:7138,x:32415,y:32773,varname:node_7138,prsc:2|A-350-T,B-4948-OUT;n:type:ShaderForge.SFN_RemapRange,id:3136,x:32714,y:32773,varname:node_3136,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-3096-OUT;proporder:7241-4948;pass:END;sub:END;*/

Shader "Shader Forge/RainbowNail" {
    Properties {
        _Color ("Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        _Speed ("Speed", Float ) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
            uniform float _Speed;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 node_350 = _Time;
                float4 node_5817_k = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
                float4 node_5817_p = lerp(float4(float4(_Color.rgb,0.0).zy, node_5817_k.wz), float4(float4(_Color.rgb,0.0).yz, node_5817_k.xy), step(float4(_Color.rgb,0.0).z, float4(_Color.rgb,0.0).y));
                float4 node_5817_q = lerp(float4(node_5817_p.xyw, float4(_Color.rgb,0.0).x), float4(float4(_Color.rgb,0.0).x, node_5817_p.yzx), step(node_5817_p.x, float4(_Color.rgb,0.0).x));
                float node_5817_d = node_5817_q.x - min(node_5817_q.w, node_5817_q.y);
                float node_5817_e = 1.0e-10;
                float3 node_5817 = float3(abs(node_5817_q.z + (node_5817_q.w - node_5817_q.y) / (6.0 * node_5817_d + node_5817_e)), node_5817_d / (node_5817_q.x + node_5817_e), node_5817_q.x);;
                float3 emissive = (lerp(float3(1,1,1),saturate(3.0*abs(1.0-2.0*frac((sin((node_350.g*_Speed))*0.5+0.5)+float3(0.0,-1.0/3.0,1.0/3.0)))-1),node_5817.g)*node_5817.b);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
