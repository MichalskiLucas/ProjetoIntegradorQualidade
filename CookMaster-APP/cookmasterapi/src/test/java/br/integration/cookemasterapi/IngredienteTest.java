package br.integration.cookemasterapi;

import br.integration.cookmasterapi.model.Ingrediente;
import br.integration.cookmasterapi.services.IngredienteService;
import org.junit.jupiter.api.*;

public class IngredienteTest {

    Ingrediente ingrediente = new Ingrediente();
    private static long id;
    private static String descricao;
    private static boolean ativo;


    @BeforeAll
    static void beforeAll() {
        id = 0;
        descricao = "";
        ativo =false;
    }

    @BeforeEach
    void setUp() {
        id = 1;
        descricao = "Maça";
        ativo = false;

        ingrediente.setId(id);
        ingrediente.setDescricao(descricao);
        ingrediente.setAtivo(ativo);
    }


    @Test
    @DisplayName("Teste para a criação de ingrediente")
    void testCreateIngrediente() {
        IngredienteService ingredienteService = new IngredienteService();
        Assertions.assertThrows(Exception.class, () -> {
            ingredienteService.validaInsert(ingrediente);
        }, "Não deve informar o ID para inserir o ingrediente");
    }

    @Test
    @DisplayName("Teste para a alteração de ingrediente")
    void testUpdateIngrediente() {
        IngredienteService ingredienteService = new IngredienteService();

        ingrediente.setDescricao("Sobremesas");

        Assertions.assertThrows(Exception.class, () -> {
            ingredienteService.validaInsert(ingrediente);
        }, "Ingrediente com a mesma descrição já inserido");
    }
}
