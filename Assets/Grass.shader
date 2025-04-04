// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Grass"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_Osiliation("Osiliation", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Osiliation;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		float4 _Texture0_TexelSize;


		float3 CombineSamplesSharp128_g2( float S0, float S1, float S2, float Strength )
		{
			{
			    float3 va = float3( 0.13, 0, ( S1 - S0 ) * Strength );
			    float3 vb = float3( 0, 0.13, ( S2 - S0 ) * Strength );
			    return normalize( cross( va, vb ) );
			}
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float2 temp_cast_0 = (( ase_vertex3Pos.x * _SinTime.z )).xx;
			float2 center45_g1 = float2( 0.5,0.5 );
			float2 delta6_g1 = ( temp_cast_0 - center45_g1 );
			float angle10_g1 = ( length( delta6_g1 ) * sin( _SinTime.y ) );
			float x23_g1 = ( ( cos( angle10_g1 ) * delta6_g1.x ) - ( sin( angle10_g1 ) * delta6_g1.y ) );
			float2 break40_g1 = center45_g1;
			float2 break41_g1 = float2( 1,200 );
			float y35_g1 = ( ( sin( angle10_g1 ) * delta6_g1.x ) + ( cos( angle10_g1 ) * delta6_g1.y ) );
			float2 appendResult44_g1 = (float2(( x23_g1 + break40_g1.x + break41_g1.x ) , ( break40_g1.y + break41_g1.y + y35_g1 )));
			v.vertex.xyz += float3( ( appendResult44_g1 / _Osiliation ) ,  0.0 );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localCalculateUVsSharp110_g2 = ( 0.0 );
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float2 temp_output_85_0_g2 = uv_Texture0;
			float2 UV110_g2 = temp_output_85_0_g2;
			float4 TexelSize110_g2 = _Texture0_TexelSize;
			float2 UV0110_g2 = float2( 0,0 );
			float2 UV1110_g2 = float2( 0,0 );
			float2 UV2110_g2 = float2( 0,0 );
			{
			{
			    UV110_g2.y -= TexelSize110_g2.y * 0.5;
			    UV0110_g2 = UV110_g2;
			    UV1110_g2 = UV110_g2 + float2( TexelSize110_g2.x, 0 );
			    UV2110_g2 = UV110_g2 + float2( 0, TexelSize110_g2.y );
			}
			}
			float4 break134_g2 = tex2D( _Texture0, UV0110_g2 );
			float S0128_g2 = break134_g2.r;
			float4 break136_g2 = tex2D( _Texture0, UV1110_g2 );
			float S1128_g2 = break136_g2.r;
			float4 break138_g2 = tex2D( _Texture0, UV2110_g2 );
			float S2128_g2 = break138_g2.r;
			float temp_output_91_0_g2 = 1.5;
			float Strength128_g2 = temp_output_91_0_g2;
			float3 localCombineSamplesSharp128_g2 = CombineSamplesSharp128_g2( S0128_g2 , S1128_g2 , S2128_g2 , Strength128_g2 );
			o.Normal = localCombineSamplesSharp128_g2;
			float4 tex2DNode17 = tex2D( _Texture0, uv_Texture0 );
			o.Albedo = tex2DNode17.rgb;
			o.Alpha = tex2DNode17.a;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
391;73;1062;474;737.5167;-379.5935;1;True;False
Node;AmplifyShaderEditor.SinTimeNode;40;-515.9698,543.3663;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;26;-611.7244,395.785;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-344.5898,383.9301;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;58;-344.5167,479.5935;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;56;-245.5347,667.4454;Inherit;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;0;False;0;False;1,200;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;2;-545.3931,-53.22803;Inherit;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;0;False;0;False;82c39aa42ef973b4d87a1d2ca40d54d7;82c39aa42ef973b4d87a1d2ca40d54d7;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;50;-143.9344,356.838;Inherit;True;Twirl;-1;;1;90936742ac32db8449cd21ab6dd337c8;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-40.05669,597.3543;Inherit;False;Property;_Osiliation;Osiliation;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-273.0764,-68.78224;Inherit;True;Property;_TextureSample12;Texture Sample 12;2;0;Create;True;0;0;0;False;0;False;-1;82c39aa42ef973b4d87a1d2ca40d54d7;82c39aa42ef973b4d87a1d2ca40d54d7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;16;-255.8031,168.984;Inherit;False;Normal From Texture;-1;;2;9728ee98a55193249b513caf9a0f1676;13,149,0,147,0,143,0,141,0,139,0,151,0,137,0,153,0,159,0,157,0,155,0,135,0,108,0;4;87;SAMPLER2D;0;False;85;FLOAT2;0,0;False;74;SAMPLERSTATE;0;False;91;FLOAT;1.5;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;57;149.4833,456.5935;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;454.1804,-25.79719;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Grass;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;43;0;26;1
WireConnection;43;1;40;3
WireConnection;58;0;40;2
WireConnection;50;1;43;0
WireConnection;50;3;58;0
WireConnection;50;4;56;0
WireConnection;17;0;2;0
WireConnection;16;87;2;0
WireConnection;16;74;2;1
WireConnection;57;0;50;0
WireConnection;57;1;53;0
WireConnection;0;0;17;0
WireConnection;0;1;16;40
WireConnection;0;9;17;4
WireConnection;0;11;57;0
ASEEND*/
//CHKSM=6BB41A6500A75A82301D2DBBA490E0806A251804