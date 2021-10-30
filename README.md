# Sigfox-htt-api

Simple access to Sigfox backend using processing.

inspired from https://github.com/hecko/pySigfox

As for our student use case, only some data are retreived : seq nmber, data, time, device.

API documentation : [here](https://support.sigfox.com/apidocs)

Data returned by the backend :
<pre>
{
  "data": [
  
  {
      "device": {
        "id": "3068E"
      },
      "time": 1634791138000,
      "data": "17",
      "rolloverCounter": 0,
      "seqNumber": 241,
      "rinfos": [],
      "satInfos": [],
      "nbFrames": 3,
      "operator": "SIGFOX_France",
      "country": "FRA",
      "computedLocation": [],
      "lqi": 3
    },
   ....
       {
      "device": {
        "id": "3068E"
      },
      "time": 1634745563000,
      "data": "28",
      "rolloverCounter": 0,
      "seqNumber": 237,
      "rinfos": [],
      "satInfos": [],
      "nbFrames": 3,
      "operator": "SIGFOX_France",
      "country": "FRA",
      "computedLocation": [],
      "lqi": 3
    }],
  "paging": {
    "next": "https://api.sigfox.com/v2/devices/3068E/messages?limit=100&before=1634045666000"
  }
}
 

</pre>

To do : 
<pre>
  device_types_list()

  device_rename( device_id, new_name)

  device_info( device_id)

  groups_list()

  device_create( device, cert, devicetype)

  device_types_create( new)

  device_list(device_type)

</pre>
