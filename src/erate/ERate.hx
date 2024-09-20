package erate;

import openfl.errors.Error;
import openfl.net.URLRequest;
import openfl.net.URLRequestMethod;
import openfl.net.URLVariables;
import openfl.utils.Dictionary;

class ERate
{
   //  public static var allowMultipleShowEvent : Bool = false;
    
    //private static var params_dic : Dictionary = new Dictionary(true);
    
    public function new()
    {
        super();
    }
    
    public static function getParam(param1 : String) : String
    {
        return Reflect.field(params_dic, param1);
    }
    
    public static function sendEvent(param1 : String, param2 : Float) : Void
    {
        return;
        /* var variables : URLVariables = null;
        var request : URLRequest = null;
        var erateID : String = param1;
        var eventType : Float = param2;
        if (erateID == "" || Math.isNaN(eventType) == true)
        {
            return;
        }
        if (getParam("erateFlag_" + erateID) == null && eventType == 1 || allowMultipleShowEvent || eventType != 1)
        {
            if (eventType == 1)
            {
                setParam("erateFlag_" + erateID, "exposed");
            }
            variables = new URLVariables();
            variables.toolId = erateID;
            variables.eventType = eventType;
            request = new URLRequest("http://213.8.137.51/Erate/eventreport.asp");
            request.data = variables;
            request.method = URLRequestMethod.POST;
            try
            {
                sendToURL(request);
            }
            catch (e : Error)
            {
                trace("error sending erate: " + e);
            }
        } */
    }
    
    public static function setParam(param1 : String, param2 : String) : Void
    {
        Reflect.setField(params_dic, param1, param2);
    }
}


