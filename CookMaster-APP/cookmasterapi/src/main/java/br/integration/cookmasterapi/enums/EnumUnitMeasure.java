package br.integration.cookmasterapi.enums;

public enum EnumUnitMeasure {
	KG("Quilo"),
	G("Grama"),
	COLHER_CHA("Colher de chá"),
	COLHER_SOPA("Colher de sopa"),
	ML("Ml"),
	COPO("Copo"),
	XICARA_CHA("Xícara de chá");
	
	public final String value;

	private EnumUnitMeasure(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}
}
