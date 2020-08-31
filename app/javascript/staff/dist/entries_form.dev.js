"use strict";

$(document).on("turbolinks:load", function () {
  $("div.button-wrapper").on("click", "button#update-events-button", function () {
    approved = [];
    not_approved = [];
    canceled = [];
    not_canceled = [];
    $("table.entries input.approved").each(function (index, elem) {
      if ($(elem).prop("checked")) approved.push($(elem).data("entry-id"));else not_approved.push($(elem).data("entry-id"));
    });
    $("#form_approved").val(approved.join(":"));
    $("#form_not_approved").val(not_approved.join(":"));
    $("table.entries input.canceled").each(function (index, elem) {
      if ($(elem).prop("checked")) canceled.push($(elem).data("entry-id"));else not_canceled.push($(elem).data("entry-id"));
    });
    $("#form_canceled").val(canceled.join(":"));
    $("#form_not_canceled").val(not_canceled.join(":"));
    $("#div.button-wrapper form").submit();
  });
});