using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Runtime.InteropServices;

namespace UnityFilePanel
{
    public static class NativePlugin
    {
        private const string PluginName = "UnityFilePanel";

        [DllImport(PluginName)]
        public static extern IntPtr DialogOpenPanel(
            string title,
            string prompt,
            string message,
            string directory,
            bool canChooseFiles,
            bool canChooseDirectories,
            bool multipleSelection,
            string allowFileTypes);

        [DllImport(PluginName)]
        public static extern IntPtr DialogSavePanel(
            string title,
            string prompt,
            string message,
            string directory,
            string allowFileTypes);
    }
}