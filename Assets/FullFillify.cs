using UnityEngine;
using System.Collections;

public class FullFillify : MonoBehaviour {

	public float PercentFull = 0.5f;
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
		r.material.EnableKeyword ("_PercentFull");
		this.PercentFull = (Mathf.Sin (Time.realtimeSinceStartup)) / 2.0f;
		//Debug.LogFormat ("Radi: {0}", radi);
		r.material.SetFloat ("_PercentFull", this.PercentFull);
	}
}