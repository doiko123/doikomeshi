// 利用規約に同意のチェックを入れた場合のみフォームをsubmitできるようにしている
$(document).on("change", ".top-page #agree-check", function () {
  // フォームのsubmitボタン
  const submitButton = $(".top-page #submit-button");

  if ($(this).prop("checked")) {
    console.log("あああ");
    submitButton.removeClass("disable");
    submitButton.prop("disabled", false);
  } else {
    submitButton.addClass("disable");
    submitButton.prop("disabled", true);
  }
});