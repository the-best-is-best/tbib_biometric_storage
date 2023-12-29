package com.tbib.biometricstorage

import android.content.Context

class CheckFileExist {
    fun fileExists(context: Context, filename: String): Boolean {
        val file = context.getFileStreamPath(filename)
        return file?.exists() ?: false
    }

}