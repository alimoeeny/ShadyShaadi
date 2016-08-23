Shader "Custom/FillItUpTexture" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SecondTex ("SecondTexture", 2D) = "black" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_PercentFull ("PercentFull", Range(-0.5,0.5)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
     	sampler2D _SecondTex;
		float _PercentFull;

		struct Input {
			float2 uv_MainTex;
			float3 localPos;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void vert (inout appdata_base v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.localPos = v.vertex.xyz;
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			if (IN.localPos.y < _PercentFull) { 
            	o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * _Color;
            } else {
             	o.Albedo = tex2D(_SecondTex, IN.uv_MainTex).rgb * _Color;
             }
			
			// Albedo comes from a texture tinted by color
			//fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			//o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			//o.Metallic = _Metallic;
			//o.Smoothness = _Glossiness;
			//o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
