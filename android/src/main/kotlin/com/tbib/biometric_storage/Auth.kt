package com.tbib.biometric_storage
import android.content.Context
import androidx.annotation.UiThread
import androidx.annotation.WorkerThread
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume

@UiThread
class Auth {
    suspend fun authenticate(context: Context , activity: FragmentActivity): Boolean = suspendCancellableCoroutine { continuation ->
        val executor = ContextCompat.getMainExecutor(context)
        val biometricPrompt = BiometricPrompt(
            activity,
            executor,
            object : BiometricPrompt.AuthenticationCallback() {
                @WorkerThread
                override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                    continuation.resume(true) // Resume with success
                }
                @WorkerThread
                override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                    println("error code is $errorCode - message $errString")
                    // Handle error and resume with appropriate value
                }
                @WorkerThread
                override fun onAuthenticationFailed() {

                    println("auth failed")
                    // Handle failure and resume with appropriate value
                }
            })
        val promptInfo = BiometricPrompt.PromptInfo.Builder()
            .setTitle("Biometric Authentication")
            .setSubtitle("Confirm your identity")
            .setNegativeButtonText("Cancel")
            .build()

        biometricPrompt.authenticate(promptInfo)

        continuation.invokeOnCancellation {
            biometricPrompt.cancelAuthentication() // Cancel if coroutine is cancelled
        }
    }
}