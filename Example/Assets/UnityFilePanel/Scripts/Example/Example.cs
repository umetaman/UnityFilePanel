using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Runtime.InteropServices;

namespace UnityFilePanel
{
    public class Example : MonoBehaviour
    {
        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {
            if (Input.GetKeyDown(KeyCode.O))
            {
                var path = Dialog.OpenFile("Choose your file", "OK", "Choose your file", new[] { "txt" }, Application.dataPath);
                var text = System.IO.File.ReadAllText(path);
                Debug.Log(text);
            }

            if (Input.GetKeyDown(KeyCode.S))
            {
                var path = Dialog.SaveFile("Save your file", "SAVE", "Save your file", new[] { "txt" }, Application.dataPath);
                System.IO.File.WriteAllText(path, "UnityFilePanel");
            }
        }
    }
}