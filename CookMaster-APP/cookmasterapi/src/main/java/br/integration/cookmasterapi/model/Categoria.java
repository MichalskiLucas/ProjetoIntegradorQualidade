package br.integration.cookmasterapi.model;

import javax.persistence.*;
import javax.validation.constraints.Null;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "categoria")
@ApiModel(description = "Modelo para representação de uma entidade de categoria")
@Api
@Data
public class Categoria {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String descricao;

    @Type(type = "org.hibernate.type.BinaryType")
    private byte[] imagem;


}
