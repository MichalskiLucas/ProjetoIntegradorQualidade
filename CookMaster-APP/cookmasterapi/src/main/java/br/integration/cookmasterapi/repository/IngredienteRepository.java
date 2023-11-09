package br.integration.cookmasterapi.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import br.integration.cookmasterapi.model.Ingrediente;
@Repository
public interface IngredienteRepository extends JpaRepository<Ingrediente,Long>{

	@Query
	public List<Ingrediente> findByDescricaoContainingAllIgnoringCase(String descricao);
	
	@Query
	public Ingrediente findIngredienteByDescricao(String descricao);
	
}
