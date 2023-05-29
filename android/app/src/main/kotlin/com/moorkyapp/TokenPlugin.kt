package com.moorkyapp

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONException
import java.util.*
import kotlin.collections.HashMap
import com.moorkyapp.src.im.zego.serverassistant.utils.TokenServerAssistant


class TokenPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private var methodChannel: MethodChannel? = null
    private var binding: FlutterPlugin.FlutterPluginBinding? = null
    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(binding.getBinaryMessenger(), "token_plugin")
        methodChannel!!.setMethodCallHandler(this)
        this.binding = binding
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel!!.setMethodCallHandler(null)
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        if (call.method.equals("makeToken")) {
            val appIDObject: Any = Objects.requireNonNull(call.argument("appID"))
            val appID: Long
            appID = if (appIDObject is Int) {
                appIDObject.toLong()
            } else if (appIDObject is Long) {
                appIDObject
            } else {
                0
            }
            val userID: String? = call.argument("userID")
            val secret: String? = call.argument("secret")
            var tokenInfo: TokenServerAssistant.TokenInfo? = null
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                try {
                    tokenInfo = TokenServerAssistant.generateToken04(
                        appID,
                        userID,
                        secret,
                        60 * 60 * 24,
                        ""
                    )
                } catch (e: JSONException) {
                    e.printStackTrace()
                }
            }
            val resultMap = HashMap<String, String>()
            resultMap["token"] = tokenInfo!!.data.toString()
            result.success(resultMap)
        }
    }
}