using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Runtime.InteropServices;

namespace UnityFilePanel
{
    public static class Dialog
    {
        /// <summary>
        /// NSOpenPanel
        /// </summary>
        /// <param name="title"></param>
        /// <param name="buttonLabel"></param>
        /// <param name="message"></param>
        /// <param name="extensions"></param>
        /// <param name="directory"></param>
        /// <param name="canChooseFiles"></param>
        /// <param name="canChooseDirectories"></param>
        /// <param name="multipleSelection"></param>
        /// <returns></returns>
        public static string NSOpenPanel(
            string title,
            string buttonLabel,
            string message,
            string[] extensions,
            string directory = "",
            bool canChooseFiles = true,
            bool canChooseDirectories = false,
            bool multipleSelection = false)
        {
            var ptr = NativePlugin.DialogOpenPanel(title, buttonLabel, message, directory, canChooseFiles, canChooseDirectories, multipleSelection, string.Join(",", extensions));
            return Marshal.PtrToStringAnsi(ptr);
        }

        /// <summary>
        /// Get the path of the single file.
        /// </summary>
        /// <param name="title"></param>
        /// <param name="buttonLabel"></param>
        /// <param name="message"></param>
        /// <param name="extensions"></param>
        /// <param name="directory"></param>
        /// <returns></returns>
        public static string OpenFile(string title, string buttonLabel, string message, string[] extensions, string directory)
        {
            return NSOpenPanel(title, buttonLabel, message, extensions, directory, true, false, false);
        }

        /// <summary>
        /// Get the path of the multiple files.
        /// </summary>
        /// <param name="title"></param>
        /// <param name="buttonLabel"></param>
        /// <param name="message"></param>
        /// <param name="extensions"></param>
        /// <param name="directory"></param>
        /// <returns></returns>
        public static string OpenMultipleFile(string title, string buttonLabel, string message, string[] extensions, string directory = "")
        {
            return NSOpenPanel(title, buttonLabel, message, extensions, directory, true, false, true);
        }

        /// <summary>
        /// Get the path of the folder.
        /// </summary>
        /// <param name="title"></param>
        /// <param name="buttonLabel"></param>
        /// <param name="message"></param>
        /// <param name="directory"></param>
        /// <returns></returns>
        public static string OpenFolder(string title, string buttonLabel, string message, string directory = "")
        {
            return NSOpenPanel(title, buttonLabel, message, new string[0], directory, false, true, false);
        }

        /// <summary>
        /// Get the path of the multiple folder
        /// </summary>
        /// <param name="title"></param>
        /// <param name="buttonLabel"></param>
        /// <param name="message"></param>
        /// <param name="directory"></param>
        /// <returns></returns>
        public static string OpenMultipleFolder(string title, string buttonLabel, string message, string directory = "")
        {
            return NSOpenPanel(title, buttonLabel, message, new string[0], directory, false, true, true);
        }

        /// <summary>
        /// Determine the path of the file to be saved.
        /// </summary>
        /// <param name="title"></param>
        /// <param name="buttonLabel"></param>
        /// <param name="message"></param>
        /// <param name="extensions"></param>
        /// <param name="directory"></param>
        /// <returns></returns>
        public static string SaveFile(
            string title,
            string buttonLabel,
            string message,
            string[] extensions,
            string directory = "")
        {
            var ptr = NativePlugin.DialogSavePanel(title, buttonLabel, message, directory, string.Join(',', extensions));
            return Marshal.PtrToStringAnsi(ptr);
        }
    }
}