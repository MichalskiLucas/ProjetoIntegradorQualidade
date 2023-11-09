package br.integration.cookmasterapi.repository;

import br.integration.cookmasterapi.model.ReceitaIngrediente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReceitaIngredienteRepository extends JpaRepository<ReceitaIngrediente, Long> {

//    @Query
//    public List<Preparo> findByDescricaoContainingAllIgnoringCase(String descricao);
}
