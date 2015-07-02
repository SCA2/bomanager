$(document).ready(updateName);
$(document).on('change', '#bom_id', updateName);

function updateName() {
  var optionSelected = $(this).find('option:selected');
  $('#bom_name').val(optionSelected.text());
};

