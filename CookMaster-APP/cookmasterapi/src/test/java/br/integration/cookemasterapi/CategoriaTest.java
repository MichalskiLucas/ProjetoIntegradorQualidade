package br.integration.cookemasterapi;

import br.integration.cookmasterapi.dto.CategoriaDto;
import br.integration.cookmasterapi.services.CategoriaService;
import org.junit.jupiter.api.*;

public class CategoriaTest {

    private CategoriaDto categoriaDto = new CategoriaDto();
    private static long id;
    private static String descricao;


    @BeforeAll
    static void beforeAll() {
        CategoriaService categoriaService = new CategoriaService();
        id = 0;
        descricao = "";
    }


    @BeforeEach
    void setUp() {
        id = 1;
        descricao = "Sobremesas";
        categoriaDto.setId(id);
        categoriaDto.setDescricao(descricao);
    }

    @Test
    @DisplayName("Teste para a criação da categoria")
    void testCreateCategoria() {
        CategoriaService categoriaService = new CategoriaService();
        Assertions.assertThrows(Exception.class, () -> {
            categoriaService.validaInsert(categoriaDto);
        }, "Para inserir uma nova categoria, não deve-se informar o ID");
    }

    @Test
    @DisplayName("Teste para a alteração da categoria")
    void testUpdateCategoria() {
        CategoriaService categoriaService = new CategoriaService();

        categoriaDto.setDescricao("Sobremesas");
        Assertions.assertThrows(Exception.class, () -> {
            categoriaService.validaInsert(categoriaDto);
        }, "Categoria com a mesma descrição já inserido");
    }
}
