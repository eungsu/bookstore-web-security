package com.example.store.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.store.paging.Pagable;
import com.example.store.vo.PointHistory;

@Mapper
public interface PointHistoryMapper {

	void insertPointHistory(PointHistory pointHistory);
	List<PointHistory> getMyPointHistories(@Param("pagable") Pagable pagable, @Param("userId") int userId);
}
