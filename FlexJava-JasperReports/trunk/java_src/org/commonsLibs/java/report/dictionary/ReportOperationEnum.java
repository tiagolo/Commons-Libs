package org.commonsLibs.java.report.dictionary;

public enum ReportOperationEnum
{
    INSERT(1L),
    UPDATE(2L),
    DELETE(3L),
    EXECUTE(4L);
    
    private Long operationID;

    public Long getOperationID()
    {
        return operationID;
    }

    public void setOperationID(Long operationID)
    {
        this.operationID = operationID;
    }

    ReportOperationEnum(Long operationId)
    {
        setOperationID(operationId);
    }
}
