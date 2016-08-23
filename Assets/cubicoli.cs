using UnityEngine;
using System.Collections;

public class cubicoli : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		Renderer r = this.gameObject.GetComponent<Renderer> ();
		if (r == null) {
			Debug.Log ("Where is my renderer dude");
			return;
		}
		r.material.EnableKeyword ("_Radius");
		float radi = Mathf.Sin (Time.realtimeSinceStartup) + 5.0f;
		//Debug.LogFormat ("Radi: {0}", radi);
		r.material.SetFloat ("_Radius", radi);
	}
}
