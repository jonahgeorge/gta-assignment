# jQuery ->
#   $("[data-behavior~=expand_on_click]").on "click", (event) ->
#     $(this).closest("[data-behavior~=expandable]").addClass("expanded")
#     event.preventDefault()
#
#   $("[data-behavior~=collapse_on_click]").on "click", (event) ->
#     $(this).closest("[data-behavior~=expandable]").removeClass("expanded")
#     event.preventDefault()
