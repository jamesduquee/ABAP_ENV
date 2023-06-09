CLASS zcl_hs_program_on_cloud_jde DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hs_program_on_cloud_jde IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA(lt_para) = request->get_form_fields( ).
    READ TABLE lt_para REFERENCE INTO DATA(lr_para) WITH KEY name = 'input'.
    IF sy-subrc = 0.

      CASE lr_para->value.

        WHEN 'send'.
          response->set_text( |Hello, Welcome to Cloud Project| ).

        WHEN 'more'.
          response->set_text( |Visit abaper.weebly.com| ).

        WHEN 'system'.

          response->set_text( | Executed by {
                               cl_abap_context_info=>get_user_technical_name( ) } | &&
                               |{ cl_abap_context_info=>get_system_date( ) DATE = ENVIRONMENT }| ).


        WHEN 'consume'.
          response->set_text( NEW zcl_api_hub_main_jde( )->get_country_details( )  )  .

        WHEN OTHERS.
          response->set_status( i_code = 400 i_reason = 'Wrong Value Passed').

      ENDCASE.
    ELSE.
      response->set_status( i_code = 400 i_reason = 'Invalid Parameter Passed').
    ENDIF.
  ENDMETHOD.
ENDCLASS.
