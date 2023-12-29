package com.tbib.biometric_storage

import android.content.Context

class CheckFileExist {
    fun fileExists(context: Context, filename: String): Boolean {
        val file = context.getFileStreamPath(filename)
        return file?.exists() ?: false
    }

}