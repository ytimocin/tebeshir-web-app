/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.entity.classes;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author yetkin.timocin
 */
@Entity
@Table(name = "mainboardmap", catalog = "tebeshir", schema = "alex")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Mainboardmap.findAll", query = "SELECT m FROM Mainboardmap m"),
    @NamedQuery(name = "Mainboardmap.findByBoardid", query = "SELECT m FROM Mainboardmap m WHERE m.boardid = :boardid"),
    @NamedQuery(name = "Mainboardmap.findByBoardname", query = "SELECT m FROM Mainboardmap m WHERE m.boardname = :boardname"),
    @NamedQuery(name = "Mainboardmap.findByParentboardid", query = "SELECT m FROM Mainboardmap m WHERE m.parentboardid = :parentboardid"),
    @NamedQuery(name = "Mainboardmap.findByBoardtype", query = "SELECT m FROM Mainboardmap m WHERE m.boardtype = :boardtype"),
    @NamedQuery(name = "Mainboardmap.findByBoarddepth", query = "SELECT m FROM Mainboardmap m WHERE m.boarddepth = :boarddepth"),
    @NamedQuery(name = "Mainboardmap.findByBoardstatus", query = "SELECT m FROM Mainboardmap m WHERE m.boardstatus = :boardstatus")})
public class Mainboardmap implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "boardid")
    private BigDecimal boardid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "boardname")
    private String boardname;
    @Basic(optional = false)
    @NotNull
    @Column(name = "parentboardid")
    private BigInteger parentboardid;
    @Column(name = "boardtype")
    private BigInteger boardtype;
    @Column(name = "boarddepth")
    private BigInteger boarddepth;
    @Basic(optional = false)
    @NotNull
    @Column(name = "boardstatus")
    private BigInteger boardstatus;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "boardid")
    private Collection<Mainboardimages> mainboardimagesCollection;

    public Mainboardmap() {
    }

    public Mainboardmap(BigDecimal boardid) {
        this.boardid = boardid;
    }

    public Mainboardmap(BigDecimal boardid, String boardname, BigInteger parentboardid, BigInteger boardstatus) {
        this.boardid = boardid;
        this.boardname = boardname;
        this.parentboardid = parentboardid;
        this.boardstatus = boardstatus;
    }

    public BigDecimal getBoardid() {
        return boardid;
    }

    public void setBoardid(BigDecimal boardid) {
        this.boardid = boardid;
    }

    public String getBoardname() {
        return boardname;
    }

    public void setBoardname(String boardname) {
        this.boardname = boardname;
    }

    public BigInteger getParentboardid() {
        return parentboardid;
    }

    public void setParentboardid(BigInteger parentboardid) {
        this.parentboardid = parentboardid;
    }

    public BigInteger getBoardtype() {
        return boardtype;
    }

    public void setBoardtype(BigInteger boardtype) {
        this.boardtype = boardtype;
    }

    public BigInteger getBoarddepth() {
        return boarddepth;
    }

    public void setBoarddepth(BigInteger boarddepth) {
        this.boarddepth = boarddepth;
    }

    public BigInteger getBoardstatus() {
        return boardstatus;
    }

    public void setBoardstatus(BigInteger boardstatus) {
        this.boardstatus = boardstatus;
    }

    @XmlTransient
    public Collection<Mainboardimages> getMainboardimagesCollection() {
        return mainboardimagesCollection;
    }

    public void setMainboardimagesCollection(Collection<Mainboardimages> mainboardimagesCollection) {
        this.mainboardimagesCollection = mainboardimagesCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (boardid != null ? boardid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Mainboardmap)) {
            return false;
        }
        Mainboardmap other = (Mainboardmap) object;
        if ((this.boardid == null && other.boardid != null) || (this.boardid != null && !this.boardid.equals(other.boardid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tebeshir.entity.classes.Mainboardmap[ boardid=" + boardid + " ]";
    }
    
}
