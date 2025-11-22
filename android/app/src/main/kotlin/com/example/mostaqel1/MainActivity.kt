package com.example.mostaqel1

import android.content.Intent
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "h3_printer"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "printText" -> {
                    val text = call.argument<String>("text") ?: ""
                    val success = printText(text)
                    if (success) {
                        result.success(null)
                    } else {
                        result.error("PRINT_ERROR", "Failed to print. No compatible printer app found.", null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun printText(text: String): Boolean {
        return try {
            // First try the specific H3 printer app
            val h3Intent = Intent().apply {
                action = Intent.ACTION_SEND
                setPackage("com.bld.settings.print")
                putExtra(Intent.EXTRA_TEXT, text)
                type = "text/plain"
            }
            
            if (isIntentAvailable(h3Intent)) {
                startActivity(h3Intent)
                return true
            }
            
            // Fallback 1: Try any available print app
            val printIntent = Intent().apply {
                action = Intent.ACTION_SEND
                putExtra(Intent.EXTRA_TEXT, text)
                type = "text/plain"
                addCategory(Intent.CATEGORY_DEFAULT)
            }
            
            if (isIntentAvailable(printIntent)) {
                startActivity(Intent.createChooser(printIntent, "Choose Printer App"))
                return true
            }
            
            // Fallback 2: Share via any app (including email, messaging, etc.)
            val shareIntent = Intent().apply {
                action = Intent.ACTION_SEND
                putExtra(Intent.EXTRA_TEXT, text)
                putExtra(Intent.EXTRA_SUBJECT, "Receipt")
                type = "text/plain"
            }
            
            startActivity(Intent.createChooser(shareIntent, "Share Receipt"))
            true
            
        } catch (e: Exception) {
            false
        }
    }
    
    private fun isIntentAvailable(intent: Intent): Boolean {
        val packageManager = packageManager
        return packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY) != null
    }
}