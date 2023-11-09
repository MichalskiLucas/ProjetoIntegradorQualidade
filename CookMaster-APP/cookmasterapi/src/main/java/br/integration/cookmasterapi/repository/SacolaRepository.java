package br.integration.cookmasterapi.repository;

import br.integration.cookmasterapi.model.Sacola;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SacolaRepository extends JpaRepository<Sacola,Long>{

	@Query
	public Sacola findSacolaByUsuarioId(Optional<Long> usuarioId);

}
