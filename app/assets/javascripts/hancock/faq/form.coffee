window.hancock_cms.faq.create_ajax_form = (form_selector = "#new_hancock_faq_question", wrapper_selector = "#hancock_faq_form" )->

  $(document).delegate form_selector, "ajax:complete", (event, xhr, status)->
    $(event.currentTarget).closest(wrapper_selector).html(xhr.responseText)

  $(document).delegate form_selector + " .input", 'click', (e) ->
    e.preventDefault()
    $(e.currentTarget).removeClass("field_with_errors").find('span.error').hide()
    return false
