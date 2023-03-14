CLASS zcl_api_hub_main_jde DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: constructor,
      get_country_details RETURNING VALUE(r_json) TYPE string.

    DATA: gv_web  TYPE string VALUE 'https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata/sap/',
          go_http TYPE REF TO if_web_http_client.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_api_hub_main_jde IMPLEMENTATION.
  METHOD constructor.
    go_http = cl_web_http_client_manager=>create_by_http_destination(
                        i_destination = cl_http_destination_provider=>create_by_url( gv_web ) ).
  ENDMETHOD.

  METHOD get_country_details.
    "GET_REQUEST
    DATA(lo_req) = go_http->get_http_request(  ).

    "SET_HEADER
    lo_req->set_header_fields( VALUE #(
         ( name = 'Content-Type' value = 'application/json' )
         ( name = 'Accept' value = 'application/json' )
         ( name = 'APIKey' value = 'LzAOM7gaAFLuZhvoFbRv0nD4FvQJOFpA' ) ) ).

    "SET_WEB_PATH
    lo_req->set_uri_path( i_uri_path = gv_web &&
                          'API_COUNTRY_SRV/A_Country?$top=25&$format=json' ).
    "EXECUTE
    TRY.
        DATA(lv_response) = go_http->execute( i_method = if_web_http_client=>get )->get_text( ).
      CATCH cx_web_http_client_error cx_web_message_error.
        "handle exception
    ENDTRY.

    r_json = lv_response.
  ENDMETHOD.
ENDCLASS.
