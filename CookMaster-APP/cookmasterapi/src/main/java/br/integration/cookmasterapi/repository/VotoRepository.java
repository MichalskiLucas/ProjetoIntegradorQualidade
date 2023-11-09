package br.integration.cookmasterapi.repository;

import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.model.Voto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VotoRepository extends JpaRepository<Voto,Long>{


	@Query
	public List<Voto> findVotoByReceitaId(Optional<Long> receitaId);

	@Query
	public Voto findVotoByUsuarioIdAndReceitaId(Optional<Long> usuarioId, Optional<Long> receitaId);

}
