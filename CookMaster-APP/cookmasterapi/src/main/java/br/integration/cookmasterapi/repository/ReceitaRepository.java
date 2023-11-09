package br.integration.cookmasterapi.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import br.integration.cookmasterapi.model.Categoria;
import br.integration.cookmasterapi.model.Receita;

@Repository
public interface ReceitaRepository extends JpaRepository<Receita,Long>{

	@Query
	public List<Receita> findByDescricaoContainingAllIgnoringCase(String descricao);
	
	@Query
	public List<Receita> findByCategoriaId(Long categoriaId);

	@Query("select r.id from Receita r where r.voto != null")
	List<Long> findIdReceitaWithVoto ();


	//@Query("select r from Receita r order by r.voto desc")
	List<Receita> findTop5ByOrderByVotoDesc();
}

