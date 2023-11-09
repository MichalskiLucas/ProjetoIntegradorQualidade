package br.integration.cookmasterapi.enums;

public enum EnumVoto {
	UM(1),
	DUAS(2),
	TRES(3),
	QUATRO(4),
	CINCO(5),;
	
	public final Integer value;

	private EnumVoto(Integer value) {
		this.value = value;
	}

	public Integer getValue() {
		return value;
	}
}
