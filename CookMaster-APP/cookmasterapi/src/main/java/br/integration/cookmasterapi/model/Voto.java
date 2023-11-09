package br.integration.cookmasterapi.model;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "voto")
@ApiModel(description = "Modelo para representação da entidade de voto")
@Api
@Data
public class Voto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    private Usuario usuario;

    @OneToOne
    private Receita receita;

    private int voto;

}
