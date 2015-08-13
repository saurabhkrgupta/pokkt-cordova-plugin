package com.pokkt.cordova;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONObject;

import com.app.pokktsdk.util.Logger;

public class PokktNativeExtension extends CordovaPlugin {
	
	private static PokktNativeExtension plugin = null;
	
	@Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
		
		plugin = this;
		PokktManagerHandler.setActivity(cordova.getActivity());
	}

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
		try {
	        // Common Methods
			JSONObject json = args.getJSONObject(0);
			
	        if (action.equals("setDebug")) {
	            PokktManagerHandler.setDebug(json.getBoolean("param"));
	            return true;
	        }
	        
	        else if (action.equals("showLog")) {
	            PokktManagerHandler.showLog(json.getString("param"));
	            return true;
	        }
	        
	        else if (action.equals("showToast")) {
	            PokktManagerHandler.showToast(json.getString("param"));
	            return true;
	        }
		} catch (Exception e) {
			Logger.e(e.getMessage());
            return false;
		}
		
		// ------------
		
		if (!PokktManagerHandler.syncPokktConfig(args)) {
			callbackContext.error("Invalid config-data provided with action: " + action);
			return false;
		}
		
        if (action.equals("initPokkt"))
        	PokktManagerHandler.initPokkt();
        
        else if (action.equals("isVideoAvailable")) {
			callbackContext.success(PokktManagerHandler.isVideoAvailable() ? 1 : 0);
			return true;
		}
		
        else if (action.equals("getVideoVc")) {
			callbackContext.success(String.valueOf(PokktManagerHandler.getVideoVc()));
			return true;
		}
		
        else if (action.equals("getPokktSDKVersion")) {
			callbackContext.success(PokktManagerHandler.getSDKVersion());
			return true;
		}
        
        // Session Methods
        else if (action.equals("startSession"))
            PokktManagerHandler.startSession();
        
        else if (action.equals("endSession"))
            PokktManagerHandler.endSession();

        // Offerwall Methods
        else if (action.equals("getCoins"))
            PokktManagerHandler.getCoins();
        
        else if (action.equals("getPendingCoins"))
            PokktManagerHandler.getPendingCoins();
        
        else if (action.equals("checkOfferWallCampaign"))
            PokktManagerHandler.checkOfferWallCampaign();

        // Video Methods
        else if (action.equals("getVideo"))
            PokktManagerHandler.getVideo();
        
        else if (action.equals("cacheVideoCampaign"))
            PokktManagerHandler.cacheVideoCampaign();
        
        else {
    		callbackContext.error("Unknown operation requested : " + action);
    		return false;
        }
		
        callbackContext.success();
        return true;
	}
	
	public static void NotifyCordova(String operation, String param) {
		if (plugin != null) {
			String event = String.format("javascript:cordova.fireDocumentEvent('%s', { 'param': '%s' });", operation, param);
			plugin.webView.loadUrl(event);
		}
		else {
			Logger.d("PokktNativeExtension is not available!");
		}
	}	
}
