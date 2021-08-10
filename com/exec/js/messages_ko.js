(function( factory ) {
  if ( typeof define === "function" && define.amd ) {
    define( ["jquery", "../jquery.validate"], factory );
  } else {
    factory( jQuery );
  }
}(function( $ ) {

/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: KO (Korean; �ѱ���)
 */
$.extend($.validator.messages, {
  required: "�ʼ� �׸��Դϴ�.",
  remote: "�׸��� �����ϼ���.",
  email: "��ȿ���� ���� E-Mail�ּ��Դϴ�.",
  url: "��ȿ���� ���� URL�Դϴ�.",
  date: "�ùٸ� ��¥�� �Է��ϼ���.",
  dateISO: "�ùٸ� ��¥(ISO)�� �Է��ϼ���.",
  number: "��ȿ�� ���ڰ� �ƴմϴ�.",
  digits: "���ڸ� �Է� �����մϴ�.",
  creditcard: "�ſ�ī�� ��ȣ�� �ٸ��� �ʽ��ϴ�.",
  equalTo: "���� ���� �ٽ� �Է��ϼ���.",
  extension: "�ùٸ� Ȯ���ڰ� �ƴմϴ�.",
  maxlength: $.validator.format("{0}�ڸ� ���� �� �����ϴ�. "),
  minlength: $.validator.format("{0}�� �̻� �Է��ϼ���."),
  rangelength: $.validator.format("���� ���̰� {0} ���� {1} ������ ���� �Է��ϼ���."),
  range: $.validator.format("{0} ���� {1} ������ ���� �Է��ϼ���."),
  max: $.validator.format("{0} ������ ���� �Է��ϼ���."),
  min: $.validator.format("{0} �̻��� ���� �Է��ϼ���.")
});

}));