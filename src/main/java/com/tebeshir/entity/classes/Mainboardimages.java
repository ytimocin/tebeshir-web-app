/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.entity.classes;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author yetkin.timocin
 */
@Entity
@Table(name = "mainboardimages", catalog = "tebeshir", schema = "alex")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Mainboardimages.findAll", query = "SELECT m FROM Mainboardimages m"),
    @NamedQuery(name = "Mainboardimages.findByImageid", query = "SELECT m FROM Mainboardimages m WHERE m.imageid = :imageid"),
    @NamedQuery(name = "Mainboardimages.findByImagelocation", query = "SELECT m FROM Mainboardimages m WHERE m.imagelocation = :imagelocation")})
public class Mainboardimages implements Serializable {
    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "imageid")
    private BigDecimal imageid;
    @Size(max = 2147483647)
    @Column(name = "imagelocation")
    private String imagelocation;
    @JoinColumn(name = "boardid", referencedColumnName = "boardid")
    @ManyToOne(optional = false)
    private Mainboardmap boardid;

    public Mainboardimages() {
    }

    public Mainboardimages(BigDecimal imageid) {
        this.imageid = imageid;
    }

    public BigDecimal getImageid() {
        return imageid;
    }

    public void setImageid(BigDecimal imageid) {
        this.imageid = imageid;
    }

    public String getImagelocation() {
        return imagelocation;
    }

    public void setImagelocation(String imagelocation) {
        this.imagelocation = imagelocation;
    }

    public Mainboardmap getBoardid() {
        return boardid;
    }

    public void setBoardid(Mainboardmap boardid) {
        this.boardid = boardid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (imageid != null ? imageid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Mainboardimages)) {
            return false;
        }
        Mainboardimages other = (Mainboardimages) object;
        if ((this.imageid == null && other.imageid != null) || (this.imageid != null && !this.imageid.equals(other.imageid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.tebeshir.entity.classes.Mainboardimages[ imageid=" + imageid + " ]";
    }
    
}
