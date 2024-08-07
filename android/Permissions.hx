package android;

#if (!android && !native)
#error 'extension-androidtools is not supported on your current platform'
#end
import android.jni.JNICache;

using StringTools;

/**
 * Utility class for handling Android permissions via JNI.
 */
class Permissions
{
	public static var ACCEPT_HANDOVER = "android.permission.ACCEPT_HANDOVER";
	public static var ACCESS_BACKGROUND_LOCATION = "android.permission.ACCESS_BACKGROUND_LOCATION";
	public static var ACCESS_BLOBS_ACROSS_USERS = "android.permission.ACCESS_BLOBS_ACROSS_USERS";
	public static var ACCESS_CHECKIN_PROPERTIES = "android.permission.ACCESS_CHECKIN_PROPERTIES";
	public static var ACCESS_COARSE_LOCATION = "android.permission.ACCESS_COARSE_LOCATION";
	public static var ACCESS_FINE_LOCATION = "android.permission.ACCESS_FINE_LOCATION";
	public static var ACCESS_LOCATION_EXTRA_COMMANDS = "android.permission.ACCESS_LOCATION_EXTRA_COMMANDS";
	public static var ACCESS_MEDIA_LOCATION = "android.permission.ACCESS_MEDIA_LOCATION";
	public static var ACCESS_NETWORK_STATE = "android.permission.ACCESS_NETWORK_STATE";
	public static var ACCESS_NOTIFICATION_POLICY = "android.permission.ACCESS_NOTIFICATION_POLICY";
	public static var ACCESS_SUPPLEMENTAL_APIS = "android.permission.ACCESS_SUPPLEMENTAL_APIS";
	public static var ACCESS_WIFI_STATE = "android.permission.ACCESS_WIFI_STATE";
	public static var ACCOUNT_MANAGER = "android.permission.ACCOUNT_MANAGER";
	public static var ACTIVITY_RECOGNITION = "android.permission.ACTIVITY_RECOGNITION";
	public static var ADD_VOICEMAIL = "android.permission.ADD_VOICEMAIL";
	public static var ANSWER_PHONE_CALLS = "android.permission.ANSWER_PHONE_CALLS";
	public static var BATTERY_STATS = "android.permission.BATTERY_STATS";
	public static var BIND_ACCESSIBILITY_SERVICE = "android.permission.BIND_ACCESSIBILITY_SERVICE";
	public static var BIND_APPWIDGET = "android.permission.BIND_APPWIDGET";
	public static var BIND_AUTOFILL_SERVICE = "android.permission.BIND_AUTOFILL_SERVICE";
	public static var BIND_CALL_REDIRECTION_SERVICE = "android.permission.BIND_CALL_REDIRECTION_SERVICE";
	public static var BIND_CARRIER_MESSAGING_CLIENT_SERVICE = "android.permission.BIND_CARRIER_MESSAGING_CLIENT_SERVICE";
	public static var BIND_CARRIER_MESSAGING_SERVICE = "android.permission.BIND_CARRIER_MESSAGING_SERVICE";
	public static var BIND_CARRIER_SERVICES = "android.permission.BIND_CARRIER_SERVICES";
	public static var BIND_CHOOSER_TARGET_SERVICE = "android.permission.BIND_CHOOSER_TARGET_SERVICE";
	public static var BIND_COMPANION_DEVICE_SERVICE = "android.permission.BIND_COMPANION_DEVICE_SERVICE";
	public static var BIND_CONDITION_PROVIDER_SERVICE = "android.permission.BIND_CONDITION_PROVIDER_SERVICE";
	public static var BIND_CONTROLS = "android.permission.BIND_CONTROLS";
	public static var BIND_DEVICE_ADMIN = "android.permission.BIND_DEVICE_ADMIN";
	public static var BIND_DREAM_SERVICE = "android.permission.BIND_DREAM_SERVICE";
	public static var BIND_INCALL_SERVICE = "android.permission.BIND_INCALL_SERVICE";
	public static var BIND_INPUT_METHOD = "android.permission.BIND_INPUT_METHOD";
	public static var BIND_MIDI_DEVICE_SERVICE = "android.permission.BIND_MIDI_DEVICE_SERVICE";
	public static var BIND_NFC_SERVICE = "android.permission.BIND_NFC_SERVICE";
	public static var BIND_NOTIFICATION_LISTENER_SERVICE = "android.permission.BIND_NOTIFICATION_LISTENER_SERVICE";
	public static var BIND_PRINT_SERVICE = "android.permission.BIND_PRINT_SERVICE";
	public static var BIND_QUICK_ACCESS_WALLET_SERVICE = "android.permission.BIND_QUICK_ACCESS_WALLET_SERVICE";
	public static var BIND_QUICK_SETTINGS_TILE = "android.permission.BIND_QUICK_SETTINGS_TILE";
	public static var BIND_REMOTEVIEWS = "android.permission.BIND_REMOTEVIEWS";
	public static var BIND_SCREENING_SERVICE = "android.permission.BIND_SCREENING_SERVICE";
	public static var BIND_TELECOM_CONNECTION_SERVICE = "android.permission.BIND_TELECOM_CONNECTION_SERVICE";
	public static var BIND_TEXT_SERVICE = "android.permission.BIND_TEXT_SERVICE";
	public static var BIND_TV_INPUT = "android.permission.BIND_TV_INPUT";
	public static var BIND_TV_INTERACTIVE_APP = "android.permission.BIND_TV_INTERACTIVE_APP";
	public static var BIND_VISUAL_VOICEMAIL_SERVICE = "android.permission.BIND_VISUAL_VOICEMAIL_SERVICE";
	public static var BIND_VOICE_INTERACTION = "android.permission.BIND_VOICE_INTERACTION";
	public static var BIND_VPN_SERVICE = "android.permission.BIND_VPN_SERVICE";
	public static var BIND_VR_LISTENER_SERVICE = "android.permission.BIND_VR_LISTENER_SERVICE";
	public static var BIND_WALLPAPER = "android.permission.BIND_WALLPAPER";
	public static var BLUETOOTH = "android.permission.BLUETOOTH";
	public static var BLUETOOTH_ADMIN = "android.permission.BLUETOOTH_ADMIN";
	public static var BLUETOOTH_ADVERTISE = "android.permission.BLUETOOTH_ADVERTISE";
	public static var BLUETOOTH_CONNECT = "android.permission.BLUETOOTH_CONNECT";
	public static var BLUETOOTH_PRIVILEGED = "android.permission.BLUETOOTH_PRIVILEGED";
	public static var BLUETOOTH_SCAN = "android.permission.BLUETOOTH_SCAN";
	public static var BODY_SENSORS = "android.permission.BODY_SENSORS";
	public static var BODY_SENSORS_BACKGROUND = "android.permission.BODY_SENSORS_BACKGROUND";
	public static var BROADCAST_PACKAGE_REMOVED = "android.permission.BROADCAST_PACKAGE_REMOVED";
	public static var BROADCAST_SMS = "android.permission.BROADCAST_SMS";
	public static var BROADCAST_STICKY = "android.permission.BROADCAST_STICKY";
	public static var BROADCAST_WAP_PUSH = "android.permission.BROADCAST_WAP_PUSH";
	public static var CALL_COMPANION_APP = "android.permission.CALL_COMPANION_APP";
	public static var CALL_PHONE = "android.permission.CALL_PHONE";
	public static var CALL_PRIVILEGED = "android.permission.CALL_PRIVILEGED";
	public static var CAMERA = "android.permission.CAMERA";
	public static var CAPTURE_AUDIO_OUTPUT = "android.permission.CAPTURE_AUDIO_OUTPUT";
	public static var CHANGE_COMPONENT_ENABLED_STATE = "android.permission.CHANGE_COMPONENT_ENABLED_STATE";
	public static var CHANGE_CONFIGURATION = "android.permission.CHANGE_CONFIGURATION";
	public static var CHANGE_NETWORK_STATE = "android.permission.CHANGE_NETWORK_STATE";
	public static var CHANGE_WIFI_MULTICAST_STATE = "android.permission.CHANGE_WIFI_MULTICAST_STATE";
	public static var CHANGE_WIFI_STATE = "android.permission.CHANGE_WIFI_STATE";
	public static var CLEAR_APP_CACHE = "android.permission.CLEAR_APP_CACHE";
	public static var CONTROL_LOCATION_UPDATES = "android.permission.CONTROL_LOCATION_UPDATES";
	public static var DELETE_CACHE_FILES = "android.permission.DELETE_CACHE_FILES";
	public static var DELETE_PACKAGES = "android.permission.DELETE_PACKAGES";
	public static var DELIVER_COMPANION_MESSAGES = "android.permission.DELIVER_COMPANION_MESSAGES";
	public static var DIAGNOSTIC = "android.permission.DIAGNOSTIC";
	public static var DISABLE_KEYGUARD = "android.permission.DISABLE_KEYGUARD";
	public static var DUMP = "android.permission.DUMP";
	public static var EXPAND_STATUS_BAR = "android.permission.EXPAND_STATUS_BAR";
	public static var FACTORY_TEST = "android.permission.FACTORY_TEST";
	public static var FOREGROUND_SERVICE = "android.permission.FOREGROUND_SERVICE";
	public static var GET_ACCOUNTS = "android.permission.GET_ACCOUNTS";
	public static var GET_ACCOUNTS_PRIVILEGED = "android.permission.GET_ACCOUNTS_PRIVILEGED";
	public static var GET_PACKAGE_SIZE = "android.permission.GET_PACKAGE_SIZE";
	public static var GET_TASKS = "android.permission.GET_TASKS";
	public static var GLOBAL_SEARCH = "android.permission.GLOBAL_SEARCH";
	public static var HIDE_OVERLAY_WINDOWS = "android.permission.HIDE_OVERLAY_WINDOWS";
	public static var HIGH_SAMPLING_RATE_SENSORS = "android.permission.HIGH_SAMPLING_RATE_SENSORS";
	public static var INSTALL_LOCATION_PROVIDER = "android.permission.INSTALL_LOCATION_PROVIDER";
	public static var INSTALL_PACKAGES = "android.permission.INSTALL_PACKAGES";
	public static var INSTALL_SHORTCUT = "android.permission.INSTALL_SHORTCUT";
	public static var INSTANT_APP_FOREGROUND_SERVICE = "android.permission.INSTANT_APP_FOREGROUND_SERVICE";
	public static var INTERACT_ACROSS_PROFILES = "android.permission.INTERACT_ACROSS_PROFILES";
	public static var INTERNET = "android.permission.INTERNET";
	public static var KILL_BACKGROUND_PROCESSES = "android.permission.KILL_BACKGROUND_PROCESSES";
	public static var LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK = "android.permission.LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK";
	public static var LOADER_USAGE_STATS = "android.permission.LOADER_USAGE_STATS";
	public static var LOCATION_HARDWARE = "android.permission.LOCATION_HARDWARE";
	public static var MANAGE_DOCUMENTS = "android.permission.MANAGE_DOCUMENTS";
	public static var MANAGE_EXTERNAL_STORAGE = "android.permission.MANAGE_EXTERNAL_STORAGE";
	public static var MANAGE_MEDIA = "android.permission.MANAGE_MEDIA";
	public static var MANAGE_ONGOING_CALLS = "android.permission.MANAGE_ONGOING_CALLS";
	public static var MANAGE_OWN_CALLS = "android.permission.MANAGE_OWN_CALLS";
	public static var MANAGE_WIFI_AUTO_JOIN = "android.permission.MANAGE_WIFI_AUTO_JOIN";
	public static var MANAGE_WIFI_INTERFACES = "android.permission.MANAGE_WIFI_INTERFACES";
	public static var MASTER_CLEAR = "android.permission.MASTER_CLEAR";
	public static var MEDIA_CONTENT_CONTROL = "android.permission.MEDIA_CONTENT_CONTROL";
	public static var MODIFY_AUDIO_SETTINGS = "android.permission.MODIFY_AUDIO_SETTINGS";
	public static var MODIFY_PHONE_STATE = "android.permission.MODIFY_PHONE_STATE";
	public static var MOUNT_FORMAT_FILESYSTEMS = "android.permission.MOUNT_FORMAT_FILESYSTEMS";
	public static var MOUNT_UNMOUNT_FILESYSTEMS = "android.permission.MOUNT_UNMOUNT_FILESYSTEMS";
	public static var NEARBY_WIFI_DEVICES = "android.permission.NEARBY_WIFI_DEVICES";
	public static var NFC = "android.permission.NFC";
	public static var NFC_PREFERRED_PAYMENT_INFO = "android.permission.NFC_PREFERRED_PAYMENT_INFO";
	public static var NFC_TRANSACTION_EVENT = "android.permission.NFC_TRANSACTION_EVENT";
	public static var OVERRIDE_WIFI_CONFIG = "android.permission.OVERRIDE_WIFI_CONFIG";
	public static var PACKAGE_USAGE_STATS = "android.permission.PACKAGE_USAGE_STATS";
	public static var PERSISTENT_ACTIVITY = "android.permission.PERSISTENT_ACTIVITY";
	public static var POST_NOTIFICATIONS = "android.permission.POST_NOTIFICATIONS";
	public static var PROCESS_OUTGOING_CALLS = "android.permission.PROCESS_OUTGOING_CALLS";
	public static var QUERY_ALL_PACKAGES = "android.permission.QUERY_ALL_PACKAGES";
	public static var READ_ASSISTANT_APP_SEARCH_DATA = "android.permission.READ_ASSISTANT_APP_SEARCH_DATA";
	public static var READ_BASIC_PHONE_STATE = "android.permission.READ_BASIC_PHONE_STATE";
	public static var READ_CALENDAR = "android.permission.READ_CALENDAR";
	public static var READ_CALL_LOG = "android.permission.READ_CALL_LOG";
	public static var READ_CONTACTS = "android.permission.READ_CONTACTS";
	public static var READ_EXTERNAL_STORAGE = "android.permission.READ_EXTERNAL_STORAGE";
	public static var READ_HOME_APP_SEARCH_DATA = "android.permission.READ_HOME_APP_SEARCH_DATA";
	public static var READ_INPUT_STATE = "android.permission.READ_INPUT_STATE";
	public static var READ_LOGS = "android.permission.READ_LOGS";
	public static var READ_MEDIA_AUDIO = "android.permission.READ_MEDIA_AUDIO";
	public static var READ_MEDIA_IMAGE = "android.permission.READ_MEDIA_IMAGE";
	public static var READ_MEDIA_VIDEO = "android.permission.READ_MEDIA_VIDEO";
	public static var READ_NEARBY_STREAMING_POLICY = "android.permission.READ_NEARBY_STREAMING_POLICY";
	public static var READ_PHONE_NUMBERS = "android.permission.READ_PHONE_NUMBERS";
	public static var READ_PHONE_STATE = "android.permission.READ_PHONE_STATE";
	public static var READ_PRECISE_PHONE_STATE = "android.permission.READ_PRECISE_PHONE_STATE";
	public static var READ_SMS = "android.permission.READ_SMS";
	public static var READ_SYNC_SETTINGS = "android.permission.READ_SYNC_SETTINGS";
	public static var READ_SYNC_STATS = "android.permission.READ_SYNC_STATS";
	public static var READ_VOICEMAIL = "android.permission.READ_VOICEMAIL";
	public static var REBOOT = "android.permission.REBOOT";
	public static var RECEIVE_BOOT_COMPLETED = "android.permission.RECEIVE_BOOT_COMPLETED";
	public static var RECEIVE_MMS = "android.permission.RECEIVE_MMS";
	public static var RECEIVE_SMS = "android.permission.RECEIVE_SMS";
	public static var RECEIVE_WAP_PUSH = "android.permission.RECEIVE_WAP_PUSH";
	public static var RECORD_AUDIO = "android.permission.RECORD_AUDIO";
	public static var REORDER_TASKS = "android.permission.REORDER_TASKS";
	public static var REQUEST_COMPANION_PROFILE_APP_STREAMING = "android.permission.REQUEST_COMPANION_PROFILE_APP_STREAMING";
	public static var REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION = "android.permission.REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION";
	public static var REQUEST_COMPANION_PROFILE_COMPUTER = "android.permission.REQUEST_COMPANION_PROFILE_COMPUTER";
	public static var REQUEST_COMPANION_PROFILE_WATCH = "android.permission.REQUEST_COMPANION_PROFILE_WATCH";
	public static var REQUEST_COMPANION_RUN_IN_BACKGROUND = "android.permission.REQUEST_COMPANION_RUN_IN_BACKGROUND";
	public static var REQUEST_COMPANION_SELF_MANAGED = "android.permission.REQUEST_COMPANION_SELF_MANAGED";
	public static var REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND = "android.permission.REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND";
	public static var REQUEST_COMPANION_USE_DATA_IN_BACKGROUND = "android.permission.REQUEST_COMPANION_USE_DATA_IN_BACKGROUND";
	public static var REQUEST_DELETE_PACKAGES = "android.permission.REQUEST_DELETE_PACKAGES";
	public static var REQUEST_IGNORE_BATTERY_OPTIMIZATIONS = "android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS";
	public static var REQUEST_INSTALL_PACKAGES = "android.permission.REQUEST_INSTALL_PACKAGES";
	public static var REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE = "android.permission.REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE";
	public static var REQUEST_PASSWORD_COMPLEXITY = "android.permission.REQUEST_PASSWORD_COMPLEXITY";
	public static var RESTART_PACKAGES = "android.permission.RESTART_PACKAGES";
	public static var SCHEDULE_EXACT_ALARM = "android.permission.SCHEDULE_EXACT_ALARM";
	public static var SEND_RESPOND_VIA_MESSAGE = "android.permission.SEND_RESPOND_VIA_MESSAGE";
	public static var SEND_SMS = "android.permission.SEND_SMS";
	public static var SET_ALARM = "android.permission.SET_ALARM";
	public static var SET_ALWAYS_FINISH = "android.permission.SET_ALWAYS_FINISH";
	public static var SET_ANIMATION_SCALE = "android.permission.SET_ANIMATION_SCALE";
	public static var SET_DEBUG_APP = "android.permission.SET_DEBUG_APP";
	public static var SET_PREFERRED_APPLICATIONS = "android.permission.SET_PREFERRED_APPLICATIONS";
	public static var SET_PROCESS_LIMIT = "android.permission.SET_PROCESS_LIMIT";
	public static var SET_TIME = "android.permission.SET_TIME";
	public static var SET_TIME_ZONE = "android.permission.SET_TIME_ZONE";
	public static var SET_WALLPAPER = "android.permission.SET_WALLPAPER";
	public static var SET_WALLPAPER_HINTS = "android.permission.SET_WALLPAPER_HINTS";
	public static var SIGNAL_PERSISTENT_PROCESSES = "android.permission.SIGNAL_PERSISTENT_PROCESSES";
	public static var SMS_FINANCIAL_TRANSACTIONS = "android.permission.SMS_FINANCIAL_TRANSACTIONS";
	public static var START_FOREGROUND_SERVICES_FROM_BACKGROUND = "android.permission.START_FOREGROUND_SERVICES_FROM_BACKGROUND";
	public static var START_VIEW_APP_FEATURES = "android.permission.START_VIEW_APP_FEATURES";
	public static var START_VIEW_PERMISSION_USAGE = "android.permission.START_VIEW_PERMISSION_USAGE";
	public static var STATUS_BAR = "android.permission.STATUS_BAR";
	public static var SYSTEM_ALERT_WINDOW = "android.permission.SYSTEM_ALERT_WINDOW";
	public static var TRANSMIT_IR = "android.permission.TRANSMIT_IR";
	public static var UNINSTALL_SHORTCUT = "android.permission.UNINSTALL_SHORTCUT";
	public static var UPDATE_DEVICE_STATS = "android.permission.UPDATE_DEVICE_STATS";
	public static var UPDATE_PACKAGES_WITHOUT_USER_ACTION = "android.permission.UPDATE_PACKAGES_WITHOUT_USER_ACTION";
	public static var USE_BIOMETRIC = "android.permission.USE_BIOMETRIC";
	public static var USE_EXACT_ALARM = "android.permission.USE_EXACT_ALARM";
	public static var USE_FINGERPRINT = "android.permission.USE_FINGERPRINT";
	public static var USE_FULL_SCREEN_INTENT = "android.permission.USE_FULL_SCREEN_INTENT";
	public static var USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER = "android.permission.USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER";
	public static var USE_SIP = "android.permission.USE_SIP";
	public static var UWB_RANGING = "android.permission.UWB_RANGING";
	public static var VIBRATE = "android.permission.VIBRATE";
	public static var WAKE_LOCK = "android.permission.WAKE_LOCK";
	public static var WRITE_APN_SETTINGS = "android.permission.WRITE_APN_SETTINGS";
	public static var WRITE_CALENDAR = "android.permission.WRITE_CALENDAR";
	public static var WRITE_CALL_LOG = "android.permission.WRITE_CALL_LOG";
	public static var WRITE_CONTACTS = "android.permission.WRITE_CONTACTS";
	public static var WRITE_EXTERNAL_STORAGE = "android.permission.WRITE_EXTERNAL_STORAGE";
	public static var WRITE_GSERVICES = "android.permission.WRITE_GSERVICES";
	public static var WRITE_SECURE_SETTINGS = "android.permission.WRITE_SECURE_SETTINGS";
	public static var WRITE_SETTINGS = "android.permission.WRITE_SETTINGS";
	public static var WRITE_SYNC_SETTINGS = "android.permission.WRITE_SYNC_SETTINGS";
	public static var WRITE_VOICEMAIL = "android.permission.WRITE_VOICEMAIL";
	
	/**
	 * Retrieves the list of permissions granted to the application.
	 *
	 * @return An array of granted permissions.
	 */
	public static inline function getGrantedPermissions():Array<String>
	{
		return JNICache.createStaticMethod('org/haxe/extension/Tools', 'getGrantedPermissions', '()[Ljava/lang/String;')();
	}

	/**
	 * Requests a specific permission from the user via a dialog.
	 *
	 * @param permission The permission to request. This should be in the format 'android.permission.PERMISSION_NAME'.
	 * @param requestCode The request code to associate with this permission request.
	 */
	public static inline function requestPermission(permission:String, requestCode:Int = 1):Void
	{
		JNICache.createStaticMethod('org/haxe/lime/GameActivity', 'requestPermission',
			'(Ljava/lang/String;I)V')(!permission.startsWith('android.permission.') ? 'android.permission.$permission' : permission, requestCode);
	}
}
