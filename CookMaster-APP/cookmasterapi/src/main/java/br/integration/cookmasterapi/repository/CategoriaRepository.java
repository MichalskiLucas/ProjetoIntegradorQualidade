package br.integration.cookmasterapi.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import br.integration.cookmasterapi.model.Categoria;
@Repository
public interface CategoriaRepository extends JpaRepository<Categoria,Long>{

	@Query
	public List<Categoria> findByDescricaoContainingAllIgnoringCase(String descricao);
	
	@Query
	public Categoria findCategoriaByDescricao(String descricao);
	
}
