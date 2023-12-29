package com.tbib.biometric_storage
import android.app.Activity
import android.content.Context
import androidx.fragment.app.FragmentActivity
import android.os.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.*
import io.flutter.plugin.common.*
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.runBlocking

/** BiometricStoragePlugin */
class BiometricStoragePlugin: FlutterPlugin, ActivityAware, MethodCallHandler {
  class MethodCallException(
     val errorCode: String? = null,
     val errorMessage: String? = null,
     val errorDetails: Any? = null
  ) : Exception(errorMessage ?: errorCode)
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context
  private  var attachedActivity: FragmentActivity? = null
  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    this.applicationContext = binding.applicationContext
    val channel = MethodChannel(binding.binaryMessenger, "biometric_storage")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    fun <T> requiredArgument(name: String) =
      call.argument<T>(name) ?: throw MethodCallException(
        "MissingArgument",
        "Missing required argument '$name'"
      )
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }

      "auth" -> {
        runBlocking {
          var isAuth = Auth().authenticate(applicationContext, attachedActivity!!)
          result.success(isAuth)
        }
      }

      "write" -> {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
          runBlocking {
              CryptoManager(applicationContext).encryptAndSave(
                requiredArgument<String>(
                  "value"
                ), requiredArgument<String>("key")

            )
          }
        } else {
          runBlocking {
              OldApiCryptoManager(applicationContext).encryptAndSave(
                requiredArgument<String>(
                  "value"
                ), requiredArgument<String>("key"), "tbib_bio_storage"
              )

          }
        }
      }
      "read"->{
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
          runBlocking {

          result.success(  CryptoManager(applicationContext).retrieveAndDecrypt(
              requiredArgument<String>("key")

            ))
          }
        } else {
          runBlocking {
            result.success(OldApiCryptoManager(applicationContext).retrieveAndDecrypt(
             requiredArgument<String>("key"), "tbib_bio_storage"
            ))

          }
        }
      }

      else -> {
        result.notImplemented()
      }
    }
  }



  override fun onDetachedFromActivity() {
    attachedActivity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    updateAttachedActivity(binding.activity)
  }

  private fun updateAttachedActivity(activity: Activity) {
    if (activity !is FragmentActivity) {
      return
    }
    attachedActivity = activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }
}
