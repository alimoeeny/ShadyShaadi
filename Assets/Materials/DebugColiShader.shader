Shader "Custom/DebugColiShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SecondTex ("SecondTexture", 2D) = "black" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Center ("Center", Vector) = (0,0,0,0)
		_Radius ("Radius", Float) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Transparent" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _SecondTex;
		float _Radius;
		float3 _Center;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float d = distance(_Center, IN.worldPos);
			float dN = 1 - saturate(d / _Radius);
			dN = step(0.25, dN) * step(dN, 0.3);
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * _Color * (1-dN) + tex2D(_SecondTex, IN.uv_MainTex).rgb * dN;
			o.Alpha =  tex2D (_MainTex, IN.uv_MainTex).a * _Color * (1-dN) + tex2D(_SecondTex, IN.uv_MainTex).a * dN;
			//if (dN > 0.25 && dN < 0.3) {
			//	o.Albedo = half3(1,1,1);
			//} else {
			// Albedo comes from a texture tinted by color
			//fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			//o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
		//	o.Metallic = _Metallic;
		//	o.Smoothness = _Glossiness;
		//	o.Alpha = c.a;
			//}
		}
		ENDCG
	}
	FallBack "Diffuse"
}
