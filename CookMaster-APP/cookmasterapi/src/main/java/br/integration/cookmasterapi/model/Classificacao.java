package br.integration.cookmasterapi.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import br.integration.cookmasterapi.enums.EnumVoto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;

@Entity
@Table(name = "classificacao")
@ApiModel(description = "Modelo para representação de uma entidade de classificação")
@Api
@Data
public class Classificacao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Receita receita;

    @ManyToOne
    private Usuario usuario;


    private EnumVoto voto;
}
