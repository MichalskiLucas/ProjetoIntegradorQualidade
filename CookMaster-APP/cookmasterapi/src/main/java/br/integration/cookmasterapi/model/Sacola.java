package br.integration.cookmasterapi.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;

@Entity
@Table(name = "sacola")
@ApiModel(description = "Modelo para representação de uma entidade sacola")
@Api
@Data
public class Sacola {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(cascade = CascadeType.ALL)
    private Usuario usuario;


    @OneToMany(cascade = CascadeType.ALL)
    private List<Ingrediente> ingredientes = new ArrayList<>();

}
