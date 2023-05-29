package com.moorkyapp


import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        //super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        try {
            flutterEngine.getPlugins().add(TokenPlugin())
        } catch (e: Exception) {
            Log.e(TAG, "Error registering plugin TokenPlugin at Demo MainActivity", e)
        }
    }

    companion object {
        private const val TAG = "ActivityPluginRegistrant"
    }
}