package br.integration.cookmasterapi.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import br.integration.cookmasterapi.model.Usuario;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario,Long>{

	@Query
	public List<Usuario> findByNomeContainingAllIgnoringCase(String nome);
	
	@Query
	public Usuario findUsuarioByEmail(String email);
	
	@Query
	public Usuario findUsuarioByNome(String nome);

	@Query
	public List<Usuario> findUsuariosByAdminIsTrue();
}
