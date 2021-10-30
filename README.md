# Sigfox-htt-api

Simple access to Sigfox backend using processing.

inspired from https://github.com/hecko/pySigfox

As for our student use case, only some data are retreived : seq nmber, data, time, device.

API documentation : [here](https://support.sigfox.com/apidocs)

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
