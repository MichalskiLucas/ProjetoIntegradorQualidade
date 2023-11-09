package br.integration.cookmasterapi.task;

import br.integration.cookmasterapi.model.Voto;
import br.integration.cookmasterapi.repository.ReceitaRepository;
import br.integration.cookmasterapi.services.ReceitaService;
import br.integration.cookmasterapi.services.VotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Component
public class ContabilizaVoto {

    @Autowired
    private ReceitaService receitaService;

    @Autowired
    private VotoService votoService;
    private List<Long> receitas = new ArrayList<>();

    private List<Voto> votos = new ArrayList<>();
    private int votoReceita;

    @Scheduled(fixedDelay = 1000)
    public void atualizaVoto() throws Exception {
//        System.out.println(
//                " Task is running ");

        getReceitas();
        //votos.clear();
        if (!receitas.isEmpty()) {
            for (Long receita : receitas) {
                try {
                    votos = votoService.findByReceitaId(receita);
                    votoReceita = 0;
                    if (!votos.isEmpty()) {
                        for (Voto voto : votos) {
                            if (voto.getVoto() > 0) {
                                votoReceita = votoReceita + voto.getVoto();
                            }
                        }

                        votoReceita = votoReceita / votos.size();

                        receitaService.updateVoto(receita, votoReceita);
                    }
                } catch (Exception ex) {
                    throw new Exception("Erro ao processar a task: ContabilizaVoto. Erro: " + ex.getMessage());
                }
            }

        }


    }


    private void getReceitas() {
        if (receitas.isEmpty()) {
            List<Long> ids = receitaService.findIdReceitaWithVoto();
            if (!ids.isEmpty())
                ids.stream().forEach(r -> receitas.add(Long.parseLong(r.toString())));
        }
    }
}

