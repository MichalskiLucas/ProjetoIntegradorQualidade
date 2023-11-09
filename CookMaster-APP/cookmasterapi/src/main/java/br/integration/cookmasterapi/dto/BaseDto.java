package br.integration.cookmasterapi.dto;

import java.io.IOException;
import java.util.List;
import java.util.zip.DataFormatException;

public abstract class BaseDto<TEntity, TDto> {

    public abstract List<TDto> getListInstance(List<TEntity> list);

    public abstract TDto getInstance(TEntity entity) throws IOException, DataFormatException;

}